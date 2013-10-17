function BeerCounter($scope, $locale) {
  $scope.beers = Strict.BeersFay.beers;
  if ($locale.id == 'en-us') {
    $scope.beerForms = Strict.Angular.ngPluralize(Strict.BeersFay.beerForms_en_us).value;
  } else {
    $scope.beerForms = Strict.Angular.ngPluralize(Strict.BeersFay.beerForms_sk).value;
  }
}
