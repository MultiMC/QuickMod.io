module VersionsHelper
    # Selection box list for version download types.
    def download_type_select_list
        [["Parallel Browser Download", :parallel_dl],
         ["Sequential Browser Download", :sequential_dl],
         ["Direct Download", :direct_dl],
        ]
    end

    def install_type_select_list
        [["Forge Mod", :forge_mod],
         ["Forge Core Mod", :forge_core_mod],
         ["Extract Mod", :extract_mod],
         ["Configuration File Package", :config_pack_mod],
         ["Group Mod", :group_mod],
        ]
    end

    # Converts the above select lists to things best_in_place will understand.
    def bip_select_list(list)
        list.map { |element| [element[1], element[0]] }
    end
end

