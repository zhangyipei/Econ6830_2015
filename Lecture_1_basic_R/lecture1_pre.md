# Lecture 1

5/18/2015

### R

##### Basic

* help system `?seq`, `??sequence`
* assignment `c()`
* arithmetic
* logical vector `!=`, `&` vs `&&`, `any`, `all`
* factor
* character
* missing values `NA`, `NaN`
* index vector for selection `a[ ]`. Either positive integer or logical vector.

example
```
# logical vectors
logi_1 = c(T,T,F)
logi_2 = c(F,T,T)

logi_12 = logi_1 & logi_2
print(logi_12)
```



##### Arrays 

* array arithematic. elementwise. 
* `%*%`, `solve`, `eigen`
* matrix

example: OLS estimator with two x regressors and a constant

##### Mixed data types

* list
* data.frame

##### Input and output

* `read.table()`
* `write.table()`

example
```
HEX = read.csv("http://ichart.finance.yahoo.com/table.csv?s=0388.HK") 
print(head(HEX))
write.csv(HEX, file = "HEX.csv")
```

##### Statitics

* `p`, `d`, `q`, `r`

example: 

1. plot the density of \\(\chi^2(3)\\) over `x_axis = seq(0.01, 15, by = 0.01)`
2. generate 1000 observations for the above distribution. plot the kernel density.
3. calculate the 95-th quantile and the empirical probability of observing a value greater than the 95-th quantile.


##### User-defined function

* `fun_name = function(args) {expressions}`
* variables defined in a functions are local.

example: given a sample, calculate the asymptotically valid 95% confidence interval according to a central limit theorem.

##### Flow control

* `if`
* `for`, `while`

example: calculate the empirical coverage probability of a poisson distribution of degree of freedom 2.

```
pts0 = Sys.time() # check time
{code block}
pts1 = Sys.time() - pts0 # check time elapse
print(pts1)
```

##### Statistical models
* `lm(y~x, data = )`



### Terminal Commands

Basic

* mkdir
* cd
* copy

Remote

* top
* screen
* ssh user@address
* start a program


### Git

References

* [Online Tutorial](https://www.atlassian.com/git/tutorials)
* [Pro Git](http://git-scm.com/book/en/v2)

#### basic commands

Local

* git config --global user.name <name>
* git config --global user.email <email>
* git init
* git status
* git add
* git commit
* git log
* git reset --hard REF
* git tag -a v1.0 -m 'message'
* git rm --cached filename
* git branch [brach_name]
* git checkout [commit_id or branch name]
* .gitignore

Remote

* git remote add origin
* git push origin master
* git config http.postBuffer 524288000 (for 500m space)
* git push -f (if the remote head if more advanced.)





#### Bonoho Git Server
During the installation, must register AP.NET 4.5.
Initial User: admin
Initial psd: admin
[http://bonobogitserver.com/prerequisites/](http://bonobogitserver.com/prerequisites/)




