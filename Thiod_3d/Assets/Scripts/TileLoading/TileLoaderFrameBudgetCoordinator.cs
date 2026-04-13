using System;
using System.Diagnostics;
using UnityEngine;

#nullable enable

namespace Thiod.TileLoading.Runtime
{

internal sealed class TileLoaderFrameBudgetCoordinator
{
    private int frameCount = -1;
    private double consumedMilliseconds;

    public void Reset()
    {
        frameCount = -1;
        consumedMilliseconds = 0d;
    }

    public bool ShouldYield(float globalBudgetMilliseconds, float localBudgetMilliseconds, Stopwatch chunkStopwatch, double minimumBudgetMilliseconds = 0.25d)
    {
        if (chunkStopwatch == null)
        {
            return false;
        }

        EnsureFrame();
        double effectiveBudgetMilliseconds = GetEffectiveBudgetMilliseconds(globalBudgetMilliseconds, localBudgetMilliseconds, minimumBudgetMilliseconds);
        if (effectiveBudgetMilliseconds <= 0d)
        {
            return false;
        }

        return consumedMilliseconds + chunkStopwatch.Elapsed.TotalMilliseconds >= effectiveBudgetMilliseconds;
    }

    public void Commit(Stopwatch chunkStopwatch)
    {
        if (chunkStopwatch == null)
        {
            return;
        }

        EnsureFrame();
        consumedMilliseconds += chunkStopwatch.Elapsed.TotalMilliseconds;
    }

    public void RestartChunk(Stopwatch chunkStopwatch)
    {
        if (chunkStopwatch == null)
        {
            return;
        }

        chunkStopwatch.Reset();
        chunkStopwatch.Start();
    }

    private double GetEffectiveBudgetMilliseconds(float globalBudgetMilliseconds, float localBudgetMilliseconds, double minimumBudgetMilliseconds)
    {
        double clampedGlobalBudgetMilliseconds = Math.Max(minimumBudgetMilliseconds, globalBudgetMilliseconds);
        double localBudget = Math.Max(minimumBudgetMilliseconds, localBudgetMilliseconds);
        double remainingGlobalBudgetMilliseconds = Math.Max(minimumBudgetMilliseconds, clampedGlobalBudgetMilliseconds - consumedMilliseconds);
        return Math.Min(localBudget, remainingGlobalBudgetMilliseconds);
    }

    private void EnsureFrame()
    {
        int currentFrameCount = Time.frameCount;
        if (frameCount == currentFrameCount)
        {
            return;
        }

        frameCount = currentFrameCount;
        consumedMilliseconds = 0d;
    }
}

}
