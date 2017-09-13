class base::repos(
  $repos = []
) {

  create_resources('yumrepos', $repos)
}
