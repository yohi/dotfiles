-- lua_add {{{

print('heirline.lua')

local conditions = require("heirline.conditions")

local utils = require("heirline.utils")

local colors = {
    bright_bg = utils.get_highlight("Folded").bg,
    bright_fg = utils.get_highlight("Folded").fg,
    red = utils.get_highlight("DiagnosticError").fg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("NonText").fg,
    orange = utils.get_highlight("Constant").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("diffDeleted").fg,
    git_add = utils.get_highlight("diffAdded").fg,
    git_change = utils.get_highlight("diffChanged").fg,
}

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}
-- We can now define some children separately and add them later

local FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}

local FileName = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = "[+]",
        hl = { fg = "green" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = "",
        hl = { fg = "orange" },
    },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            -- use `force` because we need to override the child's hl foreground
            return { fg = "cyan", bold = true, force=true }
        end
    end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
    FileIcon,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
    { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
)

local StatusLine = {
    {
        FileNameBlock,
    }
}

local WinBar = {
}

local TabLine = {
}

local StatusColumn = {
}


-- the winbar parameter is optional!
require("heirline").setup({
    statusline = StatusLine,
    winbar = WinBar,
    tabline = TabLine,
    statuscolumn = StatusColumn,
    opts = {
        colors = colors,
    },
})
local prequire    = require('utils').prequire
local listinfos   = require('utils').listinfos

local heirline    = prequire('heirline')
local utils       = prequire('heirline.utils')
local conditions  = prequire('heirline.conditions')

local p = prequire('config.heirline.parts')

local vim = vim

if not heirline then
  return
end

local Align       = { provider = '%=' }

local FileInfo    = p.create_part(p.get_filename, 'file')
local Readonly    = p.create_part(p.get_readonly, 'file')
local Modified    = p.create_part(p.get_modified, 'file')
local Filename    = { FileInfo, Readonly, Modified }

local Mode        = p.create_part(require('hardline.parts.mode').get_item, 'mode')
local Git         = p.create_part(require('hardline.parts.git').get_item, 'high')

local Dirname     = p.create_part(p.get_dirname, 'med')
local LspError    = p.create_part(p.get_lsp_errors, 'warning')
local LspWarning  = p.create_part(p.get_lsp_warnings, 'warning')
local Whitespace  = p.create_part(require('hardline.parts.whitespace').get_item, 'warning')
local Filetype    = p.create_part(require('hardline.parts.filetype').get_item, 'high')
local Lines       = p.create_part(require('hardline.parts.line').get_item, 'warning')
local ListInfos   = p.create_part(listinfos, 'warning')
local Context     = p.create_part(require('nvim-navic').get_location, 'file')

local Statusline = {
  Mode,
  Git,
  Dirname,
  Align,
  LspError,
  LspWarning,
  Whitespace,
  Filetype,
  Lines,
  ListInfos,
}

local Winbar = {
  Filename,
  Align,
  Context,
}

local TablineFileName = {
  provider = function(self)
    return p.get_tabline_filename(self.tabnr)
  end,
  hl = function(self)
    return { bold = self.is_active or self.is_visible, italic = true }
  end,
}

local TablineFileNameBlock = {
  hl = function(self)
    if self.is_active then
      return 'CurSearch'
    else
      return 'TabLine'
    end
  end,
  TablineFileName,
}

heirline.setup({
  statusline = { Statusline },
  winbar = { Winbar },
  tabline = { utils.make_tablist(TablineFileNameBlock) },
  opts = {
    disable_winbar_cb = function(args)
      return conditions.buffer_matches({
        buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'terminal', },
        filetype = { '^git.*', 'fugitive', 'Trouble', 'packer', 'fugitiveblame', },
      }, args.buf)
    end,
  },
})

-- }}}
