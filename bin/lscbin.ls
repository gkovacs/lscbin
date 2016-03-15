require! {
  fs
  glob
  livescript
}

infiles = process.argv[2 to]
if infiles.length == 0
  infiles = glob.sync('**').filter((x) -> x.indexOf('node_modules') == -1 and x.indexOf('.git') == -1 and x.slice(-3) == '.ls')

for filename in infiles
  if filename.slice(-3) != '.ls'
    continue
  outfile = filename.slice(0, -3)
  fs.writeFileSync outfile, '#!/usr/bin/env node\n' + livescript.compile(fs.readFileSync(filename, 'utf-8'))
  fs.chmodSync outfile, '0755'
