function TodoCtrl($scope) {
  state = new Strict.TodoFay.initialState(7);

  $scope.state = function () {
    return state;
  }

  $scope.addTodo = function() {
    state = Strict.TodoFay.addTodo(state);
  };

  $scope.remaining = function() {
    return Strict.TodoFay.remaining(state)
  }
 
  $scope.archive = function() {
    state = Strict.TodoFay.archive(state);
  };
}
