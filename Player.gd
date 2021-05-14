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

# A simplistic player class
extends KinematicBody

# Initialize a gravity vector
export var gravity = Vector3.DOWN * 10
# Initialize a velocity vector
var velocity = Vector3.ZERO

# Rudimentary player movement - this should be done using velocity and 
# interpolation in a real implementation.
func _input(event):	
	if Input.is_key_pressed(KEY_W):
		transform.origin.x -= 0.1
	
	if Input.is_key_pressed(KEY_S):
		transform.origin.x += 0.1
		
	if Input.is_key_pressed(KEY_A):
		transform.origin.z += 0.1
	
	if Input.is_key_pressed(KEY_D):
		transform.origin.z -= 0.1

# Just adds gravity
func _physics_process(delta):
	velocity += gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)
