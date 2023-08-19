using Godot;
using System;

public class Player : KinematicBody2D
{
    private const int GridSize = 32;
    private const int MovementSpeed = 100;

    private Vector2 targetPosition;
    private bool isMoving = false;

    public override void _Ready()
    {
        targetPosition = Position;
    }

    public override void _Process(float delta)
    {
        if (!isMoving)
        {
            // Check for input to start movement
            var inputVector = new Vector2();

            if (Input.IsActionJustPressed("ui_right"))
                inputVector.x += 1;
            else if (Input.IsActionJustPressed("ui_left"))
                inputVector.x -= 1;
            else if (Input.IsActionJustPressed("ui_down"))
                inputVector.y += 1;
            else if (Input.IsActionJustPressed("ui_up"))
                inputVector.y -= 1;

            if (inputVector != Vector2.Zero)
            {
                // Calculate the target position on the grid
                Vector2 targetGrid = new Vector2(Mathf.RoundToInt(targetPosition.x / GridSize),
                                                 Mathf.RoundToInt(targetPosition.y / GridSize));
                targetGrid += inputVector;

                // Ensure the target position stays within the grid bounds
                targetGrid.x = Mathf.Clamp(targetGrid.x, 0, 31);
                targetGrid.y = Mathf.Clamp(targetGrid.y, 0, 31);

                // Calculate the actual target position in the game world
                targetPosition = targetGrid * GridSize;

                // Start moving towards the target position
                isMoving = true;
            }
        }

        if (isMoving)
        {
            // Move towards the target position
            var velocity = (targetPosition - Position).Normalized() * MovementSpeed;
            MoveAndSlide(velocity);

            // Check if we reached the target position
            if ((targetPosition - Position).Length() < 1)
            {
                // Snap to the exact target position to avoid floating-point imprecisions
                Position = targetPosition;
                isMoving = false;
            }
        }
    }
}
