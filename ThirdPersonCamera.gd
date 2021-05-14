################################################################################
# Copyright 2021 Alanna Kelly (https://alannakelly.ie/)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy 
# of this software and associated documentation files (the "Software"), to deal 
# in the Software without restriction, including without limitation the rights 
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
# copies of the Software, and to permit persons to whom the Software is 
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
# SOFTWARE.
################################################################################

# A rudimentary third person camera Node for Godot
extends Camera

# Export this so we can set the target in the inspector
export(NodePath) var target
# Rho is the distance from target to the camera
var rho = 10
# Theta is the angle of the camera relative to the target
var theta = 0
# Get the actual node of the target
onready var targetNode = get_node(target)

# Prepare the Node
func _ready():
	# Set distance and angle relative to plater heading (our polar axis).
	update()
	# Set initial camera height.
	transform.origin.y = targetNode.transform.origin.y

# Process input for camera. Plain arithmetic used for clarity. In a real
# implementation you should use time based interpolation for camera movement.
func _input(event):	
	# Mouse left and right rotates the camera around the target.
	if event is InputEventMouseMotion:
		if event.relative.x > 1:  # Mouse moved Rightwards
			theta -= 0.1
		elif event.relative.x < -1: # Mouse moved Leftwards
			theta += 0.1
		
		# Mouse up or down adjusts camera height. The y-position of the camera 
		# effectively becomes the z (height) in standard mathematical notation 
		# for cylindrical coordinates (ρ, φ, z) (rho, theta, zee). See 
		# https://en.wikipedia.org/wiki/Cylindrical_coordinate_system for more
		# information.
		if event.relative.y > 1:
			transform.origin.y -= 0.1
		elif event.relative.y < -1:
			transform.origin.y += 0.1

# Update camera	position and rotation
func update():
	# Polar to Cartesian coordinate transform. The xz plane is treated as a 2D
	# plane here. See
	# https://en.wikipedia.org/wiki/Polar_coordinate_system for more 
	# information.
	transform.origin.x = targetNode.transform.origin.x + rho * cos(theta)
	transform.origin.z = targetNode.transform.origin.z + rho * sin(theta)
	
# Update camera postion and make it look at the target
func _process(delta):
	update()
	# Always make the camera look at the target.
	look_at(Vector3(targetNode.transform.origin.x,
					targetNode.transform.origin.y,
					targetNode.transform.origin.z),
			Vector3(0,1,0))
