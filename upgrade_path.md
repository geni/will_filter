# Versions
- 3.2 - ruby 2.2
- 4.0 - ruby >= 1.9.3
- 4.1 - ruby >= 2.2.2
- 4.2 - ruby >= 2.2.2
- 5.0 - ruby >= 2.2.2
- 5.1 - ruby >= 2.2.2
- 5.2 - ruby >= 2.2.2
- 6.0 - ruby >= 2.5.0
- 6.1 - ruby >= 2.5.0
- 7.0 - ruby >= 2.7.0
- 7.1 - ruby >= 2.7.0
- 7.2 - ruby >= 3.1.0
- 8.0 - ruby >= 3.2.0
- 8.1 - ruby >= 3.2.0


# Steps

## Create branch
```sh
git co <current version>
git co -b <next version>
```

## Setup for dual boot
```sh
next_rails --init

# update Gemfile
``

## Invoke claude
```sh
# disable colorized output
export NO_COLOR=1

claude "upgrade this gem to rails <next version>. make sure claude_test.sh passes"

# commit changes
```

## Remove old code
Use the following prompt to remove the old code:
``
now remove the old code so its only rails <next version> compatible and make sure test_my_app.sh passes
``



