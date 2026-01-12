VAR
    TopFloor: TopFloor;
    GroundFloor: GroundFloor;
END_VAR

// Initialize the top floor components
TopFloor();

// Initialize the ground floor components
GroundFloor();
```

This code defines a `FUNCTION_BLOCK` named `Home` which contains two variables: `TopFloor` and `GroundFloor`. These variables are instances of the `TopFloor` and `GroundFloor` function blocks, respectively. The code then initializes these components by calling their respective function blocks. This setup allows the `Home` function block to manage and coordinate the operations of both the top and ground floors, leveraging the functionality defined in the respective function blocks.