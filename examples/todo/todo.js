function TodoCtrl($scope) {
  var state = new Strict.TodoFay.initialState(7);
  var sc = Strict.TodoFay.todoSC;

  $scope.state = function () {
    return state;
  }

  var mutate = function (f) {
    return (function () {
      console.log("mutate " + f)
      state = Strict.TodoFay[f](state);
    })
  }

  var fayget = function (f) {
    return (function () {
      return Strict.TodoFay[f](state);
    })
  }

  console.log(state.todos);
  console.log(sc.muts);
  for (var m in sc.muts) {
    console.log("Setting up mutator for " + sc.muts[m]);
    $scope[sc.muts[m]] = mutate(sc.muts[m]);
  }

  for (var g in sc.gets) {
    $scope[sc.gets[g]] = fayget(sc.gets[g]);
  }
}
