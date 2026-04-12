# Contributing to airbnbtools

Thanks for your interest in `airbnbtools`! This package is developed for the
UBC DSCI 310 (2025W2) Airbnb price-prediction project, and we welcome bug
reports, feature ideas, and pull requests from teammates and outside
contributors alike.

By participating in this project you agree to abide by our
[Code of Conduct](CODE_OF_CONDUCT.md).

## Reporting issues

If you find a bug or have a feature request, please
[open a GitHub issue](https://github.com/UBC-DSCI-310-2025W2/airbnbtools/issues).
A good bug report includes:

- A short, descriptive title.
- A minimal reproducible example (a few lines of R that trigger the problem).
- The R version and `sessionInfo()` output.
- What you expected to happen, and what actually happened.

For feature requests, describe the use case and how the feature would help —
not just the proposed implementation.

## Proposing changes

For anything beyond a typo or one-line fix, please open an issue first to
discuss the change. This avoids duplicated work and gives us a chance to
agree on the approach before code is written.

## Development workflow

We use a standard GitHub flow. The rules below apply to teammates and
external contributors.

1. **Branch from `main`.** Use one branch per feature or fix. Name branches
   `feature/<short-description>` or `fix/<short-description>` (e.g.
   `feature/add-rmsle`, `fix/split-data-na-handling`).
2. **Commit in small, meaningful units.** Write commit messages in the
   imperative mood with a subject line of 72 characters or fewer
   (e.g. "Add RMSLE helper" rather than "added some stuff").
3. **Open a pull request targeting `main`.** Describe what changed and why,
   and link to the related issue.
4. **At least one teammate must review and approve** your PR before it can
   be merged. Reviewers should check correctness, tests, and documentation.
5. **CI must be green.** GitHub Actions runs `R CMD check` and the
   `testthat` suite on every push and pull request. PRs should not be
   merged until the workflow passes.
6. **Use GitHub issues for project communication.** Keep design discussion,
   questions, and decisions on the issue or PR thread so they're visible to
   the whole team — not in private DMs or external chat.

## Code style

- Follow the [tidyverse style guide](https://style.tidyverse.org/) for R
  code (snake_case names, two-space indentation, `<-` for assignment, etc.).
- Document every exported function with a `roxygen2` block. Include
  `@param`, `@return`, `@export`, and at least one runnable `@examples`
  entry.
- After editing any roxygen block, run `devtools::document()` so the
  generated `man/*.Rd` files and `NAMESPACE` stay in sync. Commit those
  generated files alongside your source change.

## Tests

- Tests live in `tests/testthat/` and use the `testthat` framework.
- Add a test for every new function and every bug fix (the test should fail
  before your fix and pass after).
- Run the full suite locally with `devtools::test()` before pushing.
- Do not write tests that depend on network access, external data files
  outside the repo, or randomness without a fixed seed.

## Code of Conduct

Please note that the `airbnbtools` project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this
project, you agree to abide by its terms.

## Attribution

These contributing guidelines are adapted from the
[tidyverse contributing guide](https://github.com/tidyverse/.github/blob/main/CONTRIBUTING.md).
