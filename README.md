#### Pure lua plugin give f|t|F|T{char} __buffer safe__ highlights

#### add below codes to your plugin config

``` lua
    ...
    { "some other plugin name" },

    { "gukz/ftFT.nvim" },

    { "some other plugin name" },
    ...
```

#### map to default f t F T or your own favourite keys
```vim
nnoremap f <cmd>lua require('ftFT').execute('f')<CR>
nnoremap t <cmd>lua require('ftFT').execute('t')<CR>
nnoremap F <cmd>lua require('ftFT').execute('F')<CR>
nnoremap T <cmd>lua require('ftFT').execute('T')<CR>

nnoremap df <cmd>lua require('ftFT').execute('df')<CR>
nnoremap yf <cmd>lua require('ftFT').execute('yf')<CR>
nnoremap cf <cmd>lua require('ftFT').execute('cf')<CR>
```

#### Change highlight group used if you want
```vim
" This is default
let g:ftFT_hl_group = 'Search'
```

#### use f|t|F|T{char}, you will see something different, enjoy it!

![image](https://github.com/gukz/ftFT.nvim/blob/master/image/nvim_ftFT.png)
