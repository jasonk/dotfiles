if getline(1) =~ '^#!.*\<tsx\>'
  set filetype=typescript
elseif getline(1) =~ '^#!.*\<ts-node\>'
  set filetype=typescript
elseif getline(1) =~ '^#!.*\<ts-node-esm\>'
  set filetype=typescript
elseif getline(1) =~ '^#!.*\<node\>'
  set filetype=javascript
endif
