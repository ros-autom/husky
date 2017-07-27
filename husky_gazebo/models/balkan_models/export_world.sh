source /usr/share/gazebo/setup.sh
echo -n "World file name: "
read world_file
echo
echo -n "Dem file name: "
read dem_map
echo
echo -n "World directory: "
read dir
echo

if [ -z "$world_file" ] && [ -z "$dem_map" ] && [ -z "$dir" ]
then
	echo "No arguments passed. Script will be terminated."
	exit 0
fi


if [ -z "$world_file" ] #leipei to world arxeio -> kleinei
then
	echo "No world file was inserted."
	echo "Script will be terminated."
	exit 0
fi


if [ -z "$dem_map" ] #leipei to dem arxeio
then
	echo "No map .DEM map file was given."
	echo "World file will be created with instructions in the specific field."
	echo
	
	dem_map="''replace with map file name''"
	dem_empty=true
fi
if [ -z "$dir" ] #leipei to dir -> use current dir
then
	echo "No directory from which to get the world file. Current directory"
	echo "will be chosen"
	echo
	dir=$(pwd)
fi


echo "Creating file from $dir/$world_file"
echo "<?xml version="1.0" ?>
<sdf version="1.5">
  <world name="default">
    <!-- A global light source -->
    <include>
      <uri>model://sun</uri>
    </include>

    <model name="heightmap">
      <static>true</static>
      <link name="link">
        <collision name="collision">
          <geometry>
            <heightmap>
              <uri>file://$dem_map</uri>
              <size>200 200 30</size>
              <pos>0 0 0</pos>
            </heightmap>
          </geometry>
        </collision>

        <visual name="visual_abcedf">
          <geometry>
            <heightmap>
              <texture>
                <diffuse>file://media/materials/textures/dirt_diffusespecular.png</diffuse>
                <normal>file://media/materials/textures/flat_normal.png</normal>
                <size>1</size>
              </texture>
              <texture>
                <diffuse>file://media/materials/textures/grass_diffusespecular.png</diffuse>
                <normal>file://media/materials/textures/flat_normal.png</normal>
                <size>1</size>
              </texture>
              <texture>
                <diffuse>file://media/materials/textures/fungus_diffusespecular.png</diffuse>
                <normal>file://media/materials/textures/flat_normal.png</normal>
                <size>1</size>
              </texture>
              <blend>
                <min_height>2</min_height>
                <fade_dist>5</fade_dist>
              </blend>
              <blend>
                <min_height>4</min_height>
                <fade_dist>5</fade_dist>
              </blend>
              <uri>file://$dem_map</uri>
              <size>200 200 30</size>
              <pos>0 0 0</pos>
            </heightmap>
          </geometry>
        </visual>

      </link>
    </model>

  </world>
</sdf>" >> /$dir/$world_file

if [ "$dem_empty" = true ]
then
	exit 0
fi

echo "Opening file from $dir/$world_file"
gazebo /$dir/$world_file




#sto volcano.world, DE VAZW olokliro to path tou arxeiou. Vazw mono
#to onoma tou arxeiou (yannis.dem).
#ousiastika, orizw to resource path se auto to script

#GAZEBO_RESOURCE_PATH="$GAZEBO_RESOURCE_PATH:/home/yannis" 