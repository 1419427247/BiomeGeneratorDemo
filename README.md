# BiomeGeneratorDemo

Procedural Biome Map Generation Demo
This demo shows how to use the Midpoint Displacement Algorithm to create natural and random biome maps.

![Alt text](https://user-images.githubusercontent.com/33598732/257488191-b02cbc51-8e16-4eb5-9dcb-7ab87ffaf270.png)
![Alt text](https://user-images.githubusercontent.com/33598732/257488169-82f93da0-58b3-4a69-b823-a80bdf398ba3.png)
![Alt text](https://user-images.githubusercontent.com/33598732/257488180-6172c5c4-6f43-42ca-837f-08eba52b08c2.png)

The Midpoint Displacement Algorithm is a fractal algorithm that can generate natural-looking shapes by recursively subdividing a rectangle into smaller parts and displacing the midpoint randomly.

Algorithm Principles
Given an initial line segment or rectangle, recursively subdivide it and displace the midpoint or center point at each step, causing the curve or surface to take on an irregular shape. As the number of subdivisions increases, the curve or surface approaches a realistic natural landscape. Specifically, the Midpoint Displacement Algorithm involves the following steps:

1. Start with an initial square grid, with preset height values at the four corner vertices, forming a rectangle composed of (2*n + 1)^2 squares, where n is the number of preset iterations. The corner vertices can have arbitrary random attribute values and heights, as shown (black indicates empty):
![Alt text](https://user-images.githubusercontent.com/33598732/257488183-220b43f4-1027-46e5-b4ef-ac1feb878b06.png)

2. Calculate the height values and attributes of the midpoints on the four sides of the rectangle. The attribute of a midpoint is randomly chosen from one of its two adjacent corners, while the height is the average of the two corners. After the midpoints of the four sides are computed, calculate the height and attribute of the center point of the rectangle as the average of the four corners plus a random offset:

![Alt text](https://user-images.githubusercontent.com/33598732/257488186-7c288f46-6c27-4c67-b447-3b9be677e0d9.png)

3. Subdivide the rectangle into four smaller rectangles again, and repeat steps 2 and 3 until every square is filled. The final effect:

![Alt text](https://user-images.githubusercontent.com/33598732/257488190-24636371-22ab-4189-bf10-20d0d3330f3e.png)
