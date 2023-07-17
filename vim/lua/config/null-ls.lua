vim.fn['ddc#custom#patch_global']('ui', 'native')

vim.fn['ddc#custom#patch_global']('sources', {
    'around',
    'nvim-lsp',
    'file',
    'vsnip',
})

vim.fn['ddc#custom#patch_global']('sourceOptions', {
    _ = {
        matchers = {'matcher_head'},
        sorters = {'sorter_rank'},
        converters = {'converter_remove_overlap'},
    },
    around = {
        mark = 'Around',
    },
    ['nvim-lsp'] = {
      mark = 'lsp',
      matchers = {'matcher_head'},
      forceCompletionPattern = [['\.| =|->|"\w+/*']],
    },
})
