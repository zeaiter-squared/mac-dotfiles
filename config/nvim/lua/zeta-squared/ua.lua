local ua = require('ultimate-autopair')
local configs = {ua.extend_default({
    fastwarp = {
        rmap = '<A-a>',
        rcmap = '<A-a>',
    },
    tabout = {
        enable = true,
        map = '<A-t>',
        cmap = '<A-t>',
    },
})}
ua.init(configs)
