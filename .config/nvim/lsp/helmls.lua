return {
    cmd = { "helm_ls", "serve" },
    filetypes = { "helm", "yaml.helm" },
    root_markers = { "Chart.yaml", "values*.y*ml" },
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
    settings = {
        ["helm-ls"] = {
            yamlls = {
                path = "yaml-language-server",
            },
        },
    },
}
