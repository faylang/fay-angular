angular.module('components', []).
  directive('tabs', function() {
    console.log(Strict.ComponentsFay.tabs);
    var d = Strict.ComponentsFay.tabs;
    d.scope = {},
    d.controller = function($scope, $element) {
        var panes = $scope.panes = [];
 
        $scope.select = function(pane) {
          angular.forEach(panes, function(pane) {
            pane.selected = false;
          });
          pane.selected = true;
        }
 
        this.addPane = function(pane) {
          if (panes.length == 0) $scope.select(pane);
          panes.push(pane);
        }
      }
    return d;
  }).
  directive('pane', function() {
    var d = Strict.ComponentsFay.pane;
    d.scope = { title: '@' },
    d.link = function(scope, element, attrs, tabsCtrl) {
        tabsCtrl.addPane(scope);
      }
    return d;
  })
