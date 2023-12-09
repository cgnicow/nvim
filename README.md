  See [dope](https://github.com/nvimdev/dope)

## Structure

```
├── init.lua
├── lua
│   ├── core
│   │   ├── cli.lua
│   │   ├── helper.lua
│   │   ├── init.lua
│   │   ├── keymap.lua
│   │   ├── options.lua
│   │   └── pack.lua
│   ├── keymap
│   │   ├── config.lua
│   │   └── init.lua
│   └── modules
│       ├── completion
│       │   ├── config.lua
│       │   └── package.lua
│       ├── editor
│       │   ├── config.lua
│       │   └── package.lua
│       ├── tools
│       │   ├── config.lua
│       │   └── package.lua
│       └── ui
│           ├── config.lua
│           └── package.lua
├── snippets
│   ├── lua.json
│   ├── lua.lua
│   └── package.json
```

- `core` heart of dope it include the api of dope
- `modlues` plugin module and config in this folder
- `snippets` vscode snippets json file
