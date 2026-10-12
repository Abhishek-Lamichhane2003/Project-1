# AI Prompts and How I Checked My Work

I used AI as a study and coding helper. I still checked the code, rendered the
reports, and reviewed the results myself.

## Prompt about the assignment

> I have an R project about the Central Limit Theorem. I do not understand the assignment.
> Please read the files and explain what I have to do in simple words.
> How to use helper.qmd and what are it's benefit?

## Prompt about the code

> What does Monte Carlo simulation mean?
> What is the difference between one sample and many simulations?
> Can you explain what sample size means here?
> Why are several different distributions being used?
> What is the purpose of the normal distribution?
> Why is a six-sided die included?
> Why is there error in this code?
> Why is the exponential distribution included?
> What makes the small binomial distribution interesting?
> Why is the Cauchy distribution different?
> My code has a problem so can you explain the problem and help me to debug it?
> How do I know when a distribution looks approximately normal?
> What should I look for in a histogram?
> How do I read a Q-Q plot?
> What does theoretical standard error mean?
> Why should the simulated standard deviation be compared with it?
> How should I explain surprising results?
> How should I organize the results in a summary table?
> Can you explain the graphs without using complicated words?
> Can you help me check whether my explanation makes sense?


## How I checked the result

- I checked that `n` means the observations in one sample, while `N_SIMULATIONS` means the number of repeated samples.
- I checked the formulas for the mean and standard deviation of each required distribution.
- I checked that the Small Binomial uses `size = 5` and `prob = 0.10`.
- I checked that the Exponential rate is 1.
- I checked that the Cauchy analysis does not use a regular finite standard error, because that would be incorrect.
- I rendered the files and checked the graphs and tables.
- The graphs were incorrect so I asked AI to help me to correct the graphs.

## Example of iteration

> I first asked AI to explain what the project required and how the reports should be organized.
> I checked the project instructions and rendered the reports in RStudio.
> I noticed that some reports did not clearly answer every required question, especially the sample-size reasoning, the final value of `n`, and what surprised me.
> I asked AI to compare each report with the project instructions and identify anything missing.
> I added those explanations and rendered the updated reports again.
> I asked AI to polish my explanations if anything is incorrect.

## Important correction

At first, I treated every population as if the same standard-error formula applied. I corrected this for the Cauchy distribution because the ordinary CLT assumptions fail  when there is no finite mean or variance.

