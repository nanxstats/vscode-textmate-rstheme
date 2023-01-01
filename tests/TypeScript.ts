import fs = require("fs");

class MyClass {
    public static myValue: string;
    constructor(init: string) {
        this.myValue = init;
    }
}

module MyModule {
    export interface MyInterface extends Other {
        myProperty: any;
    }
}

declare magicNumber number;

// Arrow functions
myArray.forEach(() => { });
