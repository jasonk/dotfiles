if did_filetype()
  finish
endif

if getline(1) =~ '^#!.*\<uv\>'
  setfiletype python
elseif getline(1) =~ '^#!.*\<tsx\>'
  setfiletype typescript
elseif getline(1) =~ '^#!.*\<ts-node\>'
  setfiletype typescript
elseif getline(1) =~ '^#!.*\<ts-node-esm\>'
  setfiletype typescript
elseif getline(1) =~ '^#!.*\<node\>'
  setfiletype javascript
endif
