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
  var rosterHTML = '<ol>'
  $.each(this.players, function(i, player){
    rosterHTML += '<li><a href="/players/' + player.id + '">' +  player.name + '</li>';
  });
  rosterHTML += '</ol><a href="#" class="js-hide-roster btn btn-primary btn-xs" data-remote="true" data-id="' + this.team.id + '">Hide Roster</a>';
  return rosterHTML;
};

function hideRoster(){
  $(".js-hide-roster").on("click", function() {
    var id = $(this).data("id");
    $('a[data-id="' + id + '"]').parent().html('<a href="/teams/' + id + '" class="js-roster btn btn-primary btn-xs" data-remote="true" data-id="' + id + '">See Roster</a>');
    loadRoster();
  });
};