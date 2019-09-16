document.addEventListener("turbolinks:load", function() {
  if($(".users.index").length !== 0) {
		getUsers();
	}
})


function loadUsers(users) {
  var template = Handlebars.compile(document.getElementById("userLi-template").innerHTML);
  var result = template(users);
  $("#userList")[0].innerHTML = result;
}

function getUsers() {
	$.get("/users.json", function(users) {
		loadUsers(users);
	});
}