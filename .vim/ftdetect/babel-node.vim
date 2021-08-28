if getline(1) =~ '^#!.*\<babel-node\>'
  setfiletype javascript
elseif getline(1) =~ '^#!.*\<node\>'
  setfiletype javascript
elseif getline(1) =~ '^#!.*\<tsnode\>'
  setfiletype typescript
endif
