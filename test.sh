
RES=`curl -s http://localhost:4873/public-stuff -H 'Authorization: Basic Zm9vOmJhcg==' | jq .error -r`

if [ "$RES" == "no such package available" ]
then
  echo ok
else
  echo fail: $RES
fi

RES=`curl -s http://localhost:4873/private-one -H 'Authorization: Basic Zm9vOmJhcg==' | jq .error -r`

# means access granted
if [ "$RES" == "no such package available" ]
then
  echo ok
else
  echo fail: $RES
fi

RES=`curl -s http://localhost:4873/private-two -H 'Authorization: Basic Zm9vOmJhcg==' | jq .error -r`

if [ "$RES" == "you're not allowed here" ]
then
  echo ok
else
  echo fail: $RES
fi

RES=`curl -s http://localhost:4873/public-stuff -H 'Authorization: Basic Zm9vOmJhZHBhc3M=' | jq .error -r`

if [ "$RES" == "unregistered users are not allowed to access package public-stuff" ]
then
  echo ok
else
  echo fail: $RES
fi

RES=`curl -s http://localhost:4873/private-one -H 'Authorization: Basic Zm9vOmJhZHBhc3M=' | jq .error -r`

# bad password treated as non-logged-in user
if [ "$RES" == "i don't know anything about you" ]
then
  echo ok
else
  echo fail: $RES
fi

