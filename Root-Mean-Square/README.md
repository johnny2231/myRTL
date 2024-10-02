# Root-Mean-Square
To simulate waveform:
> https://www.edaplayground.com/x/pG5k

Root-mean-square(RMS) is to compute the square-root of mean of squared of groups of number.

## div.v
At first, my design didnt get the expected result.
And I noticed there is timing violation.
After some research, it seems the `*` and `/` operator will use up a lot of resources.
Therefore I decided to find a way so that I can avoid the usage of those operators, and I found a video that use shifting and minus method: https://www.youtube.com/watch?v=Iw5J7UsA_kc
This method separate the divider to first half and second half, then perform a series of shift left and minus.
Even though this method uses for loop, but the computation load is divided into two.

## sqrt.v
One of the way to model square-root.
For example, we want to perform square-root to `9`
Let `ROOT[1:0] = 00`
Then `ROOT[1] = 1`, and we check if `ROOT*ROOT > 9`
If yes, then we unset `ROOT[1]` to `0`; else remain at `1`.
In this caseit ramain at `1`.

Do the same to `ROOT[0]`, and we got our `RMS=3`
