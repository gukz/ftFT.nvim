#### Introduction
A pure Lua plugin aims to enhance the experience of the native f command (<number>f|t|F|T{char}),
it will not add extra function but only necessary highlights to help use f{char} easier.

#### Demo
After install, when you use f|t|F|T{char}, you will see something different, enjoy it!

![image](https://github.com/gukz/ftFT.nvim/blob/master/image/nvim_ftFT.png)

#### Install
1. Packer
``` lua
    ...
    { "some other plugin name" },

    { "gukz/ftFT.nvim",
      -- This will turn on all functions, if you don't like some of them, add more config to disable/change them
      config = function() require("ftFT").setup() end
    },

    { "some other plugin name" },
    ...
```
...
other plugin manager support are comming soon

#### Default behavior & Custom config
below is a overall config items, if you don't want to do any config, you can just use config in `Install` section
``` lua
    { "gukz/ftFT.nvim",
      config = function()
        vim.g.ftFT_hl_group = "Search" -- will use Search hl group to do the highlitgt

        vim.g.ftFT_keymap_keys = {"f", "t", "F"} -- Will create key binding for "f", "t", "F", but not "T"
        vim.g.ftFT_keymap_skip_n = 1  -- if set this, will not create key binding for ftFT in normal mode
        vim.g.ftFT_keymap_skip_ydc = 1  -- if set this, will not create key binding for [ydc][ftFT] in normal mode
        vim.g.ftFT_keymap_skip_v = 1  -- if set this, will not create key binding for ftFT in visual mode

        -- ftFT will show another sight line below current line, shows you how many `;` you need to jump there
        vim.g.ftFT_sight_disable = 1  -- if set this, will not have sight line
        vim.g.ftFT_sight_hl_group = "Search"  -- if set htis, will use other hl group for sight line

        require("ftFT").setup()  -- this will create default keymapping for you
      end
    },

```

you can also do the keybinding yourself
``` vim
nnoremap f <cmd>lua require('ftFT').execute('f')<CR>
nnoremap t <cmd>lua require('ftFT').execute('t')<CR>
nnoremap F <cmd>lua require('ftFT').execute('F')<CR>
nnoremap T <cmd>lua require('ftFT').execute('T')<CR>

nnoremap df <cmd>lua require('ftFT').execute('df')<CR>
nnoremap yf <cmd>lua require('ftFT').execute('yf')<CR>
nnoremap cf <cmd>lua require('ftFT').execute('cf')<CR>
```
