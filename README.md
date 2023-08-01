# BiomeGeneratorDemo

Procedural Biome Map Generation Demo
This demo shows how to use the Midpoint Displacement Algorithm to create natural and random biome maps.

![Alt text](img/%E5%9B%BE%E7%89%874.png)

![Alt text](img/%E6%96%B0%E5%BB%BA%E9%A1%B9%E7%9B%AE.png)

![Alt text](<img/屏幕截图 2023-08-01 013838.png>)

![Alt text](<img/屏幕截图 2023-08-01 171206.png>)

The Midpoint Displacement Algorithm is a fractal algorithm that can generate natural-looking shapes by recursively subdividing a rectangle into smaller parts and displacing the midpoint randomly.

Algorithm Principles
Given an initial line segment or rectangle, recursively subdivide it and displace the midpoint or center point at each step, causing the curve or surface to take on an irregular shape. As the number of subdivisions increases, the curve or surface approaches a realistic natural landscape. Specifically, the Midpoint Displacement Algorithm involves the following steps:

1. Start with an initial square grid, with preset height values at the four corner vertices, forming a rectangle composed of (2*n + 1)^2 squares, where n is the number of preset iterations. The corner vertices can have arbitrary random attribute values and heights, as shown (black indicates empty):
![Alt text](img/%E5%9B%BE%E7%89%871.png)

2. Calculate the height values and attributes of the midpoints on the four sides of the rectangle. The attribute of a midpoint is randomly chosen from one of its two adjacent corners, while the height is the average of the two corners. After the midpoints of the four sides are computed, calculate the height and attribute of the center point of the rectangle as the average of the four corners plus a random offset:

![Alt text](img/%E5%9B%BE%E7%89%872.png)

3. Subdivide the rectangle into four smaller rectangles again, and repeat steps 2 and 3 until every square is filled. The final effect:

![Alt text](img/%E5%9B%BE%E7%89%873.png)


# 生态群落地图生成示例
这个Demo展示了如何使用中点位移算法（Midpoint Displacement Algorithm）来创建自然且随机的生态群落。

![Alt text](img/%E5%9B%BE%E7%89%874.png)

![Alt text](img/%E6%96%B0%E5%BB%BA%E9%A1%B9%E7%9B%AE.png)

![Alt text](<img/屏幕截图 2023-08-01 013838.png>)

![Alt text](<img/屏幕截图 2023-08-01 171206.png>)

中点位移算法是一种分形算法，它可以通过递归地将矩形分割成更小的部分，并对每个中点进行随机的偏移，来生成自然的图形。

## 算法原理
给定一个初始的线段或矩形，然后对其进行递归的细分，每次细分时，将中点或中心点进行一次插值，使得曲线或表面呈现出不规则的形状。随着细分次数的增加，曲线或表面越来越接近真实的自然景观。具体来说，中点位移算法可以分为以下几个步骤：

1. 一开始需要一个初始的正方形网格，给定初始的四个顶点的属性和高度值，形成一个矩形，它由个(2 * n + 1) ^ 2个方格组成，其中n是预设的迭代次数。给定四个角点的属性和额外的高度值，可以是任意随机的，如图所示（黑色表示为空）。
![Alt text](img/%E5%9B%BE%E7%89%871.png)

2. 计算矩形的四条边的中点的高度值和属性，中点属性从相邻两个顶点随机选取一个，而中点高度为相邻两个顶点的平均值。当四条边的中点计算完成后开始计算矩形的中心点的高度值和属性，为四个顶点的平均值加上一个随机偏移量：

![Alt text](img/%E5%9B%BE%E7%89%872.png)

3. 将矩形再次划分为四个小矩形，重复步骤2和3，直到每个方格被设置。最终效果：
![Alt text](img/%E5%9B%BE%E7%89%873.png)
