 var myArgs = process.argv.slice(2);

var a=require(myArgs[0])

translate(a)
if ("en" in  a){
	console.log()
	translate(a.en)

}
function translate(res){
	var json = []

	json.push({pagetitle:res.title})
	for (var i in res.sections){
		json.push({type:"title",value:res.sections[i].title})
		section = res.sections[i].form
		for (var ii in section){
			json.push(section[ii])
		}
	}
	console.log(JSON.stringify(json))
}
