BEGIN{
	map="{\"type\":\"map\",\"longitude\":@lon@,\"latitude\":@lat@,\"markers\":[{\"id\":\"@id@\",\"title\":\"@marktitle@\",\"width\":30,\"height\":30,\"iconPath\":\"@marker@\",\"longitude\":@lon@,\"latitude\":@lat@}]}"
	text="{\"type\":\"text\", \"value\":\"@value@\"}"
	phone="{\"type\":\"phone\", \"value\":\"@value@\"}"
	pagetitle = "{\"pagetitle\":\"@pagetitle@\"}"
	li=	"{\"type\":\"li\", \"value\":\"@value@\"}"
	lli="{\"type\":\"lli\", \"value\":\"@value@\"}"

	FS="[]:\174]"
	english=false
	begin=0;
	print "["
}
/^!title:/{
	if (begin != 0 ) print (",")
	sub(/@pagetitle@/, $2, pagetitle)
	printf(pagetitle)
	begin=1
	next
}
/^!video/{
	if (begin != 0 ) print (",")
	sub(/:/, "\",\"value\":\"")
        sub(/^!/, "{\"type\":\"")
        sub(/\[/, "")
        sub(/\]/, "\"}")

	printf($0)
	begin=1
	next
}
/^!image/ {
	if (begin != 0 ) print (",")

	sub(/:/, "\",\"value\":\"")
	sub(/^!/, "{\"type\":\"")
	sub(/\[/, "")
	sub(/\]/, "\"}")

	printf($0)
	begin=1
	next
}
/^!phone/ {
	if (begin != 0 ) print (",")

	sub(/:/, "\",\"value\":\"")
	sub(/^!/, "{\"type\":\"")
	sub(/\[/, "")
	sub(/\]/, "\"}")

	printf($0)
	begin=1
	next
}
/^!map/ {
	if (begin != 0 ) print (",")
	thismap = map
	title =$3

	if ($4 == ""){
		$4= "/image/location.png"
	}
	sub(/@id@/,$2"]",thismap)
	sub(/@marktitle@/,$3,thismap)
	sub(/@marker@/,$4,thismap)

	split(substr($2, 2, length($2)-1), geo, ",")

	gsub(/@lon@/,geo[1],thismap)
	gsub(/@lat@/,geo[2],thismap)
	printf thismap
	begin=1
	next
}
/^\#\#\#\ /{
	if (begin != 0 ) print (",")

	sub(/^\#\#\# /, "{\"type\":\"subsubtitle\",\"value\":\"")
	printf $0
	printf "\"}"
	begin=1
	next
}
/^\#\#\ /{
	if (begin != 0 ) print (",")

	sub(/^\#\# /, "{\"type\":\"subtitle\",\"value\":\"")
	printf $0
	printf "\"}"
	begin=1
	next
}
/^\#\ / {
	if (begin != 0 ) print (",")

	sub(/^# /, "{\"type\":\"title\",\"value\":\"")

	printf $0
	printf "\"}"
	begin=1
	next
}
/^\*\* /{
	if (begin != 0 ) print (",")

	thislli = lli
	sub(/@value@/, substr($0, 3, length($0)), thislli)
	printf ("%s", thislli)
	next
}
/^\* /{
	if (begin != 0 ) print (",")

	thisli = li
	sub(/@value@/, substr($0, 3, length($0)), thisli)
	printf ("%s", thisli)
	next
}
{
	if (begin != 0 ) print (",")
	thistext = text
	sub(/@value@/, $0, thistext)
	printf ("%s", thistext)

	begin=1
}
END{
	print ""
	print "]"
}
