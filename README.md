#### Pure lua plugin give f|t|F|T{char} __buffer safe__ highlight

#### add below codes to your plugin config

``` lua
    ...
    { "some other plugin name" },
    
    { "gukz/ftFT.nvim" },
    
    { "some other plugin name" },
    ...
```

#### map to default f t F T or your own favourite keys
```
noremap f <cmd>lua require('ftFT').execute('f')<CR>
noremap t <cmd>lua require('ftFT').execute('t')<CR>
noremap F <cmd>lua require('ftFT').execute('F')<CR>
noremap T <cmd>lua require('ftFT').execute('T')<CR>

noremap df <cmd>lua require('ftFT').execute('df')<CR>
noremap yf <cmd>lua require('ftFT').execute('yf')<CR>
noremap cf <cmd>lua require('ftFT').execute('cf')<CR>
```

#### use f|t|F|T{char}, you will see different things, enjoy it!

![image](https://github.com/gukz/ftFT.nvim/blob/master/image/nvim_ftFT.png)
