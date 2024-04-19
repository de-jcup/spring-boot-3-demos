# Howto test it

Just execute 
`./start.sh` inside a bash shell.

After this the application is automatically build, started and tested (twice)

After this please compare

```
./demo/build/test-results/ciphertest/ciphertest-output-cipher1.json
./demo/build/test-results/ciphertest/ciphertest-output-cipher2.json
```

as you can see there are differences (means cipher config from application.yml is not applied with profile `cipher2`)


cipher2 profile uses ssl bundles - that is the only difference. Seems to be a bug.
