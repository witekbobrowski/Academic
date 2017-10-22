const electron = require('electron')
const {app, BrowserWindow} = electron

let win
app.on('ready', () => {
  win = new BrowserWindow({width:1280, height:720, frame:false})
  win.loadURL(`file://${__dirname}/index.html`)
})
