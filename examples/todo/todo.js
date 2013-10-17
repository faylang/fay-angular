function TodoCtrl($scope) {
  $scope.state = Strict.TodoFay.initialState;
  var sc = Strict.TodoFay.todoSC;

  var mutate = function (f) {
    return (function () {
      console.log("mutate " + f)
      $scope.state = Strict.TodoFay[f]($scope.state);
    })
  }

  var fayget = function (f) {
    return (function () {
      return Strict.TodoFay[f]($scope.state);
    })
  }

  console.log($scope.state.todos);
  console.log(sc.muts);
  for (var m in sc.muts) {
    console.log("Setting up mutator for " + sc.muts[m]);
    $scope[sc.muts[m]] = mutate(sc.muts[m]);
  }

  for (var g in sc.gets) {
    $scope[sc.gets[g]] = fayget(sc.gets[g]);
  }
}
