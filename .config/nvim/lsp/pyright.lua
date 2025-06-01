return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python", "requirements" },
    root_markers = {
        ".git",
        ".ruff.toml",
        "Pipfile",
        "pyproject.toml",
        "pyrightconfig.json",
        "requirements.txt",
        "ruff.toml",
        "setup.cfg",
        "setup.py",
    },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
}
