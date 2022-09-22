package modding;

#if polymod
import polymod.Polymod;
#end
import polymod.Polymod;
import modding.ModList;

class PolymodHandler
{
    public static var metadataArrays:Array<String> = [];

    public static function loadMods()
    {
        loadModMetadata();

		Polymod.init({
			modRoot:SUtil.getPath() + "mods/",
			dirs: ModList.getActiveMods(metadataArrays),
            framework: OPENFL,
			errorCallback: function(error:PolymodError)
			{
				#if debug
                trace(error.message);
                #end
			},
            frameworkParams: {
                assetLibraryPaths: [
                    "songs" => "songs",
                    "stages" => "stages",
                    "shared" => "shared",
                    "fonts" => "fonts", 
                    "mods" => "mods"
                ]
            }
		});
    }

    public static function loadModMetadata()
    {
        metadataArrays = [];

        var tempArray = Polymod.scan(SUtil.getPath() + "mods/","*.*.*",function(error:PolymodError) {
            #if debug
			trace(error.message);
            #end
		});

        for(metadata in tempArray)
        {
            metadataArrays.push(metadata.id);
            ModList.modMetadatas.set(metadata.id, metadata);
        }
    }
}
