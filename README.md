#### Introduction
__Everything is just same with native f|t|F|T but with useful highlights!__


#### Demo
After install, when you use f|t|F|T{char}, you will see something different, enjoy it!

![image](https://github.com/gukz/ftFT.nvim/blob/master/image/nvim_ftFT.png)

#### Install
Lazy
``` lua
  { "some other plugin name" },
  
  {
    "gukz/ftFT.nvim",
    keys = { "f", "t", "F", "T" },
    config = true,
  },
  
  { "some other plugin name" },
```

#### Default behavior & Custom config
below is a overall config items, if you don't want to do any config, you can just use config in `Install` section
``` lua
    { "gukz/ftFT.nvim",
      opts = {
        keys = {"f", "t", "F", "T"}, -- the keys that enable highlights.
        modes = {"n", "v"},   -- the modes this plugin works in.
        hl_group = "Search",  -- this property specify the hi group
        sight_hl_group = "",  -- this property specify the hi group for sight line, if not set, the sight line will not show.
      },
      config = true,
    },

```

[Not recommended] you can also do the keybinding
It can work, but this plugin will hide the cursor.
``` vim
nnoremap f <cmd>lua require('ftFT').execute('f')<CR>
nnoremap t <cmd>lua require('ftFT').execute('t')<CR>
nnoremap F <cmd>lua require('ftFT').execute('F')<CR>
nnoremap T <cmd>lua require('ftFT').execute('T')<CR>

nnoremap df <cmd>lua require('ftFT').execute('df')<CR>
nnoremap yf <cmd>lua require('ftFT').execute('yf')<CR>
nnoremap cf <cmd>lua require('ftFT').execute('cf')<CR>
```
