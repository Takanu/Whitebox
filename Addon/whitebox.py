
'''
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''

'''
    AddonPreferences keymap code adapted from pitiwazou and kilbee for 2.8.
    Grid panel code created by Maebbie.
'''

#This states the metadata for the plugin
bl_info = {
    "name": "Whitebox",
    "author": "Takanu (thanks to Maebbie for the original code).",
    "version": (1, 0, 0),
    "blender": (2, 91, 0),
    "location": "3D View > Properties",
    "wiki_url": "https://github.com/Takanu/Whitebox",
    "description": "Simple tools and assets for developing 3D level prototypes.",
    "tracker_url": "",
    "category": "3D View"
}
    

import bpy
from bpy.types import Menu
from bpy.types import Operator
from bpy.props import IntProperty, FloatProperty

import rna_keymap_ui
        
# -----------------------------------------------------------------------------
#    Preferences      
#    (thanks Bookyakuno on the Blender Artists forum)
# ----------------------------------------------------------------------------- 

# Preferences            
class AddonPreferences(bpy.types.AddonPreferences):
    bl_idname = __name__
    print("addon registering brrr")
                                    
    def draw(self, context):
        layout = self.layout
        box = layout.box()
        col = box.column()
        col.label(text="Keyboard Shortcut List:",icon="KEYINGSET")


        wm = bpy.context.window_manager
        kc = wm.keyconfigs.user
        old_km_name = ""
        get_kmi_l = []
        for km_add, kmi_add in addon_keymaps:
            for km_con in kc.keymaps:
                if km_add.name == km_con.name:
                    km = km_con
                    break

            for kmi_con in km.keymap_items:
                if kmi_add.idname == kmi_con.idname:
                    if kmi_add.name == kmi_con.name:
                        get_kmi_l.append((km,kmi_con))

        get_kmi_l = sorted(set(get_kmi_l), key=get_kmi_l.index)

        for km, kmi in get_kmi_l:
            if not km.name == old_km_name:
                col.label(text=str(km.name),icon="DOT")
            col.context_pointer_set("keymap", km)
            rna_keymap_ui.draw_kmi([], kc, km, kmi, col, 0)
            col.separator()
            old_km_name = km.name
                
# -----------------------------------------------------------------------------
#    Keymap      
# ----------------------------------------------------------------------------- 
addon_keymaps = [] 
         
def get_addon_preferences():
    ''' quick wrapper for referencing addon preferences '''
    user_preferences = bpy.context.user_preferences
    addon_prefs = user_preferences.addons[__name__].preferences
    return addon_prefs


def get_hotkey_entry_item(km, kmi_name, kmi_value):
    '''
    returns hotkey of specific type, with specific properties.name (keymap is not a dict, so referencing by keys is not enough
    if there are multiple hotkeys!)
    '''
    for i, km_item in enumerate(km.keymap_items):
        if km.keymap_items.keys()[i] == kmi_name:
            if hasattr(km.keymap_items[i].properties, 'name'):
                if km.keymap_items[i].properties.name == kmi_value:
                    return km_item
                else:
                    return None
            else:
                return km_item
    return None 



addon_keymaps = []

def add_hotkeys():
    wm = bpy.context.window_manager
    kc = wm.keyconfigs.addon 

    ### Quick Walk Navigation Shortcut (prevents users from having to fish it out the keymap menu)
    km = kc.keymaps.new(name="3D View Generic", space_type='VIEW_3D', region_type='WINDOW')  
    kmi = km.keymap_items.new("view3d.navigate",'LEFTMOUSE', 'CLICK', shift=False, ctrl=False, alt=True)     
    #kmi.properties.name = "bpy.ops.view3d.walk"  #not used for operators.         
    kmi.active = True
    addon_keymaps.append((km, kmi))

    ### Increase/Decrease Grid Size
    km2 = kc.keymaps.new(name="3D View Generic", space_type='VIEW_3D', region_type='WINDOW')  
    kmi2 = km2.keymap_items.new("scene.wbox_decreasegrid", 'MINUS', 'PRESS', shift=False, ctrl=False, alt=False)     
    kmi2.active = True
    addon_keymaps.append((km2, kmi2))

    km3 = kc.keymaps.new(name="3D View Generic", space_type='VIEW_3D', region_type='WINDOW')  
    kmi3 = km3.keymap_items.new("scene.wbox_increasegrid", 'EQUAL', 'PRESS', shift=False, ctrl=False, alt=False)     
    kmi3.active = True
    addon_keymaps.append((km3, kmi3))

    # Some debug stuff, gonna leave it here for now
    # print("\n", kmi2)
    # for attr in dir(kmi2):
    #     if not attr.startswith("_"):
    #         val = getattr(kmi2, attr)
    #         if type(val) in {int, float, str, bool}:
    #             print("\t", attr, "=", val)
    
    
def remove_hotkey():
    ''' clears all addon level keymap hotkeys stored in addon_keymaps '''
    wm = bpy.context.window_manager
    kc = wm.keyconfigs.addon
    km = kc.keymaps['3D View Generic']
    
    for km, kmi in addon_keymaps:
        km.keymap_items.remove(kmi)
    
    wm.keyconfigs.addon.keymaps.remove(km)

    addon_keymaps.clear()



# -----------------------------------------------------------------------------
#    Grid Size Adjuster      
# -----------------------------------------------------------------------------     
class WhiteboxPanel(bpy.types.Panel):
    """Creates a Panel in the Object properties window"""

    bl_label = "Whitebox"
    bl_idname = "VIEW3D_PT_Grid_Options"
    bl_space_type = 'VIEW_3D'
    bl_category = "Whitebox"
    bl_region_type = 'UI'
    

    def draw(self, context):
        layout = self.layout

        overlay = bpy.context.space_data.overlay
        scene = bpy.context.scene

        row = layout.column(align=True)
        row.label(text="Unit Options:")
        row.separator()
        row.prop(overlay, "grid_scale")
        row.separator()

        row.label(text="Material Options:")
        row.separator()
        row.prop(scene, "whitebox_grid_opacity")
        row.prop(scene, "whitebox_emission_strength")


class WHITEBOX_OT_Increase_Grid_Size(Operator):
    """Multiply the current grid size by 2."""

    bl_idname = "scene.wbox_increasegrid"
    bl_label = "Increase Grid Size"

    def execute(self, context):
        print(self)

        new_value = bpy.context.space_data.overlay.grid_scale * 2.0
        bpy.context.space_data.overlay.grid_scale = new_value

        return {'FINISHED'}

class WHITEBOX_OT_Decrease_Grid_Size(Operator):
    """Divide the current grid size by 2."""

    bl_idname = "scene.wbox_decreasegrid"
    bl_label = "Decrease Grid Size"

    def execute(self, context):
        print(self)
        
        new_value = bpy.context.space_data.overlay.grid_scale / 2.0
        bpy.context.space_data.overlay.grid_scale = new_value

        return {'FINISHED'}

# -----------------------------------------------------------------------------
#    Material Modifications  
# -----------------------------------------------------------------------------     

def WHITEBOX_Update_GridOpacity(self, context):
    """Updates the grid opacity when the Scene.whitebox_grid_opacity property is changed."""

    value = context.scene.whitebox_grid_opacity

    for k,v in bpy.data.node_groups.items():
        if k == 'Whitebox Diffuse Mix':
            
            diffuse = bpy.data.node_groups['Whitebox Diffuse Mix']
            
            for k,v in diffuse.nodes.items():
                if k == 'Global Grid Alpha':
                    diffuse.nodes['Global Grid Alpha'].inputs[1].default_value = value

def WHITEBOX_Update_EmissionStrength(self, context):
    """Updates the grid opacity when the Scene.whitebox_grid_opacity property is changed."""

    value = context.scene.whitebox_emission_strength

    for k,v in bpy.data.node_groups.items():
        if k == 'Whitebox Emission Mix':
            
            emission = bpy.data.node_groups['Whitebox Emission Mix']
        
            for k,v in emission.nodes.items():
                if k == 'Global Emission Strength':
                    emission.nodes['Global Emission Strength'].inputs[1].default_value = value
    


classes = (
    AddonPreferences, 
    WhiteboxPanel, 
    WHITEBOX_OT_Increase_Grid_Size, 
    WHITEBOX_OT_Decrease_Grid_Size,
)

         
# -----------------------------------------------------------------------------
#    Register      
# -----------------------------------------------------------------------------         
def register():
    from bpy.utils import register_class
    for cls in classes:
        register_class(cls)
    
    bpy.types.Scene.whitebox_grid_opacity = FloatProperty(
        name="Grid Opacity",
        description="Controls the opacity of the Whitebox grid overlay on all default Whitebox materials and any Material using the Whitebox Diffuse Mix or Whitebox Material Mix NodeGroups.",
        min=0.0,
        max=1.0,
        default=1.0,
        update=WHITEBOX_Update_GridOpacity,
    )

    bpy.types.Scene.whitebox_emission_strength = FloatProperty(
        name="Grid Emission Strength",
        description="Controls the emission strength of the Whitebox grid overlay on all default Whitebox materials and any Material using the Whitebox Emission Mix or Whitebox Material Mix NodeGroups.",
        min=0.0,
        soft_max=10.0,
        default=1.0,
        update=WHITEBOX_Update_EmissionStrength,
    )

    # hotkey setup
    add_hotkeys()
    
def unregister():
    from bpy.utils import unregister_class

    # hotkey cleanup
    remove_hotkey()

    del bpy.types.Scene.whitebox_emission_strength
    del bpy.types.Scene.whitebox_grid_opacity

    for cls in reversed(classes):
        unregister_class(cls)
    

if __name__ == "__main__":
    register()