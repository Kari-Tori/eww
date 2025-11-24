import tkinter as tk
import time
import math
import random

root = tk.Tk()
root.title("Dla Kubusia")
canvas = tk.Canvas(root, width=600, height=500, bg="black")
canvas.pack()

heart_points = []
for t in range(0, 628, 4):
    angle = t / 100
    x = 16 * math.sin(angle) ** 3
    y = 13 * math.cos(angle) - 5 * math.cos(2 * angle) - 2 * math.cos(3 * angle) - math.cos(4 * angle)
    screen_x = int(300 + x * 10)
    screen_y = int(250 - y * 10)
    heart_points.append((screen_x, screen_y))

def draw_stars():
    for _ in range(50):
        x = random.randint(10, 590)
        y = random.randint(10, 100)
        size = random.choice([1, 2])
        canvas.create_oval(x, y, x + size, y + size, fill="yellow", outline="")

def draw_heart():
    half = len(heart_points) // 2
    for i in range(half):
        x1, y1 = heart_points[i]
        x2, y2 = heart_points[-(i + 1)]
        canvas.create_oval(x1 - 2, y1 - 2, x1 + 2, y1 + 2, fill="red", outline="")
        canvas.create_oval(x2 - 2, y2 - 2, x2 + 2, y2 + 2, fill="red", outline="")
        root.update()
        time.sleep(0.003)

def animate():
    draw_stars()
    root.update()

    root.after(3500, draw_heart)  # Serce po 3.5 s
    root.after(6000, lambda: canvas.create_text(300, 230, text="Kubuś", fill="white", font=("Helvetica", 32, "bold")))
    root.after(8000, lambda: canvas.create_text(300, 270, text="Jesteś najlepszy", fill="white", font=("Helvetica", 18, "italic")))

root.after(300, animate)
root.mainloop()
