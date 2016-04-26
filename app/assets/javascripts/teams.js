$(document).ready(loadRoster);

function loadRoster(){
  $(".js-roster").on("click", function() {
    var id = $(this).data("id");
    var url = this.href;

    $.get(url + '.json')
      .done(function(data){
        currentRoster = new Roster(data["team"], data["team"]["players"]);
        $('a[data-id="' + id + '"]').parent().html(currentRoster.makeHTML());
        hideRoster();
      })
  });
};

function Roster(team, players){
  this.team = team;
  this.players = players;
}

Roster.prototype.makeHTML = function(){
  var source = '<ol>{{#this.players}}' +
                  '<li><a href="/players/{{id}}">{{name}}</a></li>' +
                '{{/this.players}}</ol>' +
                '<a href="#" class="js-hide-roster btn btn-primary btn-xs" data-remote="true" data-id="{{this.team.id}}">Hide Roster</a>';
  var template = Handlebars.compile(source);
  return template(this);
};

function hideRoster(){
  $(".js-hide-roster").on("click", function() {
    var id = $(this).data("id");
    $('a[data-id="' + id + '"]').parent().html('<a href="/teams/' + id + '" class="js-roster btn btn-primary btn-xs" data-remote="true" data-id="' + id + '">See Roster</a>');
    loadRoster();
  });
};