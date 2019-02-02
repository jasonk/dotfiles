if getline(1) =~ '^#!.*\<babel-node\>'
  setfiletype node
elseif getline(1) =~ '^#!.*\<node\>'
  setfiletype node
endif
