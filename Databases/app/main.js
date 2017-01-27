const electron = require('electron')
const {app, BrowserWindow} = electron

let win
app.on('ready', () => {
  win = new BrowserWindow({width:1140, height:720})
  win.loadURL(`file://${__dirname}/index.html`)
})
