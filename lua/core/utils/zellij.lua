local M = {}

local function get_nvim_pane_id()
  return os.getenv 'ZELLIJ_PANE_ID'
end

local function focus_nvim()
  local nvim_pane = get_nvim_pane_id()
  vim.fn.system(string.format('zellij action focus-pane-id %s', nvim_pane))
end

local function get_current_reference()
  local mode = vim.api.nvim_get_mode().mode
  local file_path = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.expand '%:p'), ':~:.')

  if not mode:match '[vV]' then
    return file_path
  end

  local v_start = vim.fn.getpos 'v'
  local v_end = vim.fn.getpos '.'
  local start_line, start_col = v_start[2], v_start[3]
  local end_line, end_col = v_end[2], v_end[3]

  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end

  if mode == 'V' then
    return string.format('%s:L%d-L%d', file_path, start_line, end_line)
  else
    return string.format('%s:L%d:C%d-L%d:C%d', file_path, start_line, start_col, end_line, end_col)
  end
end

---@param opts { cmd: string }
---@return table manager with show, hide, toggle, focus, close, send_ref, send_instruction
function M.create(opts)
  local pane_id = nil

  local function is_alive()
    if not pane_id then
      return false
    end
    local output = vim.fn.system 'zellij action list-panes'
    if output:find(pane_id, 1, true) then
      return true
    end
    pane_id = nil
    return false
  end

  local function is_hidden()
    local cmd = string.format("zellij action list-panes --json | jq '.[] | select(.id == %s) | .is_floating'", pane_id)
    local output = vim.fn.system(cmd)
    return vim.trim(output) == 'true'
  end

  local function show()
    if is_alive() then
      if is_hidden() then
        vim.fn.system(string.format('zellij action toggle-pane-embed-or-floating --pane-id %s', pane_id))
      end
    else
      local output = vim.fn.system(string.format('zellij run --close-on-exit --direction right -- %s', opts.cmd))
      local id = output:match '(terminal_%d+)'
      if id then
        pane_id = id
      end
    end

    focus_nvim()
  end

  local function hide()
    if not is_alive() then
      return
    end
    if is_hidden() then
      return
    end
    local nvim_pane = get_nvim_pane_id()
    if nvim_pane then
      vim.fn.system(string.format('zellij action toggle-pane-embed-or-floating --pane-id %s', pane_id))
      focus_nvim()
    end
  end

  local function toggle()
    if is_alive() then
      hide()
    else
      show()
    end
  end

  local function focus()
    show()
    vim.fn.system(string.format('zellij action focus-pane-id %s', pane_id))
  end

  local function close()
    if is_alive() then
      vim.fn.system(string.format('zellij action close-pane --pane-id %s', pane_id))
      pane_id = nil
    end
  end

  ---@param prompt string
  ---@param config? { focus: boolean?, enter: boolean? }
  local function operate(prompt, config)
    if not is_alive() then
      return
    end
    config = config or {}

    local escaped_prompt = (prompt:gsub("'", "'\\''"))
    vim.fn.system(string.format("zellij action write-chars --pane-id %s '%s'", pane_id, escaped_prompt))

    if config.enter then
      vim.fn.system(string.format('zellij action send-keys --pane-id %s Enter', pane_id))
    end

    if config.focus then
      vim.fn.system(string.format('zellij action focus-pane-id %s', pane_id))
    end
  end

  local function send_reference()
    operate(get_current_reference() .. ' ')
  end

  local function send_instruction()
    local current_ref = get_current_reference()
    local prefix = '@this:'

    vim.ui.input({
      prompt = 'Instruction: ',
      default = prefix .. ' ',
      highlight = function(input)
        local highlights = {}
        local start_idx = 1
        while true do
          local s, e = input:find('@this', start_idx)
          if not s then
            break
          end
          table.insert(highlights, { s - 1, e, 'Keyword' })
          start_idx = e + 1
        end
        return highlights
      end,
    }, function(input)
      if not input or input == '' then
        return
      end

      local processed_input = input:gsub(prefix, current_ref)
      operate(processed_input, { enter = true })
    end)
  end

  return {
    show = show,
    hide = hide,
    toggle = toggle,
    focus = focus,
    close = close,
    send_reference = send_reference,
    send_instruction = send_instruction,
  }
end

return M
