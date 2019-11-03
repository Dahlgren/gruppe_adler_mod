#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY node_modules
#endif

class GRAD_animalTransport {
    class General {
        file = MODULES_DIRECTORY\grad-animalTransport\functions;
        class controlAnimal {};
        class findSuitableSpace {};
        class findSuitableSpaces {};
        class findSuitableVehicle {};
        class findSuitableVehicles {};
        class initVars {
            preInit = 1;
        };
        class player_interactMenuClosed {};
        class player_interactMenuOpened {};
        class player_registerInteract {
            postInit = 1;
        };
        class player_unloadAnimals {};
        class registerEventHandler {
            postInit = 1;
        };
        class setYawPitchRoll {};
        class vehicle_loadAnimal {};
        class vehicle_lockCargoIndex {};
        class vehicle_unloadAnimal {};
        class vehicle_unloadAnimalDetach {};
    };
};
