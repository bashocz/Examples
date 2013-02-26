using System;

namespace Basho.Graphics.Segmentation
{
    public interface IFhSegmentation
    {
        int[,] BuildSegments(int width, int height, byte[,] pixels, int k);
    }
}
