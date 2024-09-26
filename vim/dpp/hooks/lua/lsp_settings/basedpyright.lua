print 'read settings basepyright.lua !!'

return {
    basedpyright = {
        analysis = {
            --
            -- inlayHints = {
            --     functionReturnTypes = true,
            --     variableTypes = true,
            -- },

            --
            autoImportCompletions = true,

            -- 事前定義された名前にもどついて検索パスを自動的に追加するか
            autoSearchPaths = true,

            -- [openFilesOnly, workspace]
            diagnosticMode = "openFilesOnly",

            -- 診断のレベルを上書きする
            -- https://github.com/microsoft/pylance-release/blob/main/DIAGNOSTIC_SEVERITY_RULES.md
            diagnosticSeverityOverrides = {
                reportGeneralTypeIssues = "none",
                reportMissingTypeArgument = "none",
                reportUnknownMemberType = "none",
                reportUnknownVariableType = "none",
                reportUnknownArgumentType = "none",
            },

            -- インポート解決のための追加検索パス指定
            extraPaths = {
            },

            -- default: Information [Error, Warning, Information, Trace]
            -- logLevel = 'Warning',
            logLevel = 'Trace',

            -- カスタムタイプのstubファイルを含むディレクトリ指定 default: ./typings
            -- stubPath = '',

            -- 型チェックの分析レベル default: off [off, basic, strict]
            typeCheckingMode = 'off',
            reportMissingImports = 'none',
            reportMissingModuleSource = 'none',
            reportUnusedImport = 'none',
            reportUnusedVariable = 'none',
            reportUnboundVariable = 'none',
            reportUndefinedVariable = 'none',
            reportGeneralTypeIssues = 'none',
            reportMissingTypeArgument = 'none',
            reportOptionalSubscript = 'none',
            reportOptionalMemberAccess = 'none',

            --
            -- typeshedPaths = '',

            -- default: false
            useLibraryCodeForTypes = true,

            pylintPath = {
            },
        },
    },
}
