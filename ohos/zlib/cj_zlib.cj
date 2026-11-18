/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.zlib

import ohos.business_exception.AsyncCallback
import ohos.ffi.{CArrString, toArrayCString, freeArrCString}
import ohos.labels.APILevel
import std.deriving.Derive

/**
 * CompressLevel.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum CompressLevel {
    /**
     * Compress level 0 that indicates uncompressed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressLevelNoCompression
    |
    /**
     * Compression level 1 that gives the best speed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressLevelBestSpeed
    |
    /**
     * Compression level 9 that gives the best compression.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressLevelBestCompression
    |
    /**
     * Default compression level.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressLevelDefaultCompression
    | ...

    func getValue(): Int32 {
        match (this) {
            case CompressLevelNoCompression => 0
            case CompressLevelBestSpeed => 1
            case CompressLevelBestCompression => 9
            case CompressLevelDefaultCompression => -1
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * CompressStrategy.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum CompressStrategy {
    /**
     * Default compression strategy.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressStrategyDefaultStrategy
    |
    /**
     * Filtered compression strategy.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressStrategyFiltered
    |
    /**
     * Huffman coding compression strategy.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressStrategyHuffmanOnly
    |
    /**
     * RLE compression strategy.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressStrategyRle
    |
    /**
     * Fixed compression strategy.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    CompressStrategyFixed
    | ...

    func getValue(): Int32 {
        match (this) {
            case CompressStrategyDefaultStrategy => 0
            case CompressStrategyFiltered => 1
            case CompressStrategyHuffmanOnly => 2
            case CompressStrategyRle => 3
            case CompressStrategyFixed => 4
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * MemLevel.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum MemLevel {
    /**
     * Minimum memory used by the **zlib** API during compression.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    MemLevelMin
    |
    /**
     * Maximum memory used by the **zlib** API during compression.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    MemLevelMax
    |
    /**
     * Default memory used by the **zlib** API during compression.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    MemLevelDefault
    | ...

    func getValue(): Int32 {
        match (this) {
            case MemLevelMin => 1
            case MemLevelMax => 9
            case MemLevelDefault => 8
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * CompressFlushMode.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum CompressFlushMode {
    /**
     * Default value, indicating a normal operation.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    NoFlush
    |
    /**
     * Generates some refresh points in the stream.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    PartialFlush
    |
    /**
     * Forcibly outputs all compressed data while maintaining the compression stream state.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    SyncFlush
    |
    /**
     * Resets the compression state.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    FullFlush
    |
    /**
     * Ends the compression or decompression process.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Finish
    |
    /**
     * Allows more precise control.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Block
    |
    /**
     * Implements special purposes.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Trees
    | ...

    func getValue(): Int32 {
        match (this) {
            case NoFlush => 0
            case PartialFlush => 1
            case SyncFlush => 2
            case FullFlush => 3
            case Finish => 4
            case Block => 5
            case Trees => 6
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Return codes for the compression/decompression functions.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum ReturnStatus {
    /**
     * The API is successfully called. This API is supported for use in atomic services.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Ok
    |
    /**
     * The API is successfully called, indicating that the entire data has been processed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    StreamEnd
    |
    /**
     * The API is successfully called, indicating that a preset dictionary is required to continue decompression.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    NeedDict
    |
    /**
     * The API fails to be called, indicating that the file operation is incorrect.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Errno
    |
    /**
     * The API fails to be called, indicating that the compression or decompression stream is incorrect.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    StreamError
    |
    /**
     * The API fails to be called, indicating that the input data is incorrect.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    DataError
    |
    /**
     * The API fails to be called, indicating that the memory allocation fails.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    MemError
    |
    /**
     * The API fails to be called, indicating that the input buffer is incorrect.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    BufError
    | ...

    func getValue(): Int32 {
        match (this) {
            case Ok => 0
            case StreamEnd => 1
            case NeedDict => 2
            case Errno => -1
            case StreamError => -2
            case DataError => -3
            case MemError => -4
            case BufError => -5
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }

    static func parse(val: Int32): ReturnStatus {
        match (val) {
            case 0 => Ok
            case 1 => StreamEnd
            case 2 => NeedDict
            case -1 => Errno
            case -2 => StreamError
            case -3 => DataError
            case -4 => MemError
            case -5 => BufError
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * The deflate compression method (the only one supported in this version).
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public enum CompressMethod {
    /**
     * Compression method.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    Deflated
    | ...

    func getValue(): Int32 {
        match (this) {
            case Deflated => 8
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Compresses a file. This API uses an asynchronous callback to return the result.
 *
 * **NOTE**
 *
 * To avoid path traversal, the input parameters of **inFile** and **outFile** cannot contain two consecutive periods
 * and a slash (../). Otherwise, error codes 900001 and 900002 are returned.
 *
 * @param { String } inFile - Path of the folder or file to compress. The path must be an application sandbox path,
 *     which can be obtained from the context. For details about the context, see FA Model and Stage Model. The folder
 *     to compress cannot be empty. Otherwise, an error will be reported when decompressFile is used to decompress the
 *     folder.
 * @param { String } outFile - Path of the compressed file. When multiple threads compress files at the same time, the
 *     values of **outFile** must be different.
 * @param { Options } options - Compression parameters.
 * @param { AsyncCallback<Unit> } callback - Callback used to return the result. If the operation is successful,
 *     **null** is returned; otherwise, a specific error code is returned.
 * @throws { BusinessException } 900001 - The input source file is invalid.
 * @throws { BusinessException } 900002 - The input destination file is invalid.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib",
    throwexception: true
]
public func compressFile(inFile: String, outFile: String, options: Options, callback: AsyncCallback<Unit>): Unit {
    spawn {
        unsafe {
            let cOptions = RetOptions(options)
            try (
                cInFile = LibC.mallocCString(inFile).asResource(),
                cOutFile = LibC.mallocCString(outFile).asResource()
            ) {
                let errCode = FfiBundleManagerCompressFile(cInFile.value, cOutFile.value, cOptions)
                invokeAsyncCallbackUnit(callback, errCode, "compressFile")
            }
        }
    }
}

/**
 * Compresses multiple specified files. This API uses an asynchronous callback to return the result.
 *
 * @param { Array<String> } inFiles - Path of the folder or file to compress. The path must be an application sandbox
 *     path, which can be obtained from the context. For details about the context, see FA Model and Stage Model. The
 *     folder to compress cannot be empty. Otherwise, an error will be reported when decompressFile is used to
 *     decompress the folder.
 * @param { String } outFile - Path of the compressed file. When multiple threads compress files at the same time, the
 *     values of **outFile** must be different.
 * @param { Options } options - Compression parameters.
 * @param { AsyncCallback<Unit> } callback - Callback used to return the result. If the operation is successful,
 *     **null** is returned; otherwise, a specific error code is returned.
 * @throws { BusinessException } 900001 - The input source file is invalid.
 * @throws { BusinessException } 900002 - The input destination file is invalid.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib",
    throwexception: true
]
public func compressFiles(inFiles: Array<String>, outFile: String, options: Options,
    callback: AsyncCallback<Unit>): Unit {
    spawn {
        unsafe {
            let cOptions = RetOptions(options)
            var cArgs = CArrString(CPointer<CString>(), 0)
            try (cOutFile = LibC.mallocCString(outFile).asResource()) {
                cArgs = toArrayCString(inFiles)
                let errCode = FfiBundleManagerCompressFiles(cArgs, cOutFile.value, cOptions)
                invokeAsyncCallbackUnit(callback, errCode, "compressFiles")
            } finally {
                freeArrCString(cArgs)
            }
        }
    }
}

/**
 * Decompresses a file. This API uses an asynchronous callback to return the result.
 *
 * **NOTE**
 *
 * To avoid path traversal, the input parameters of **inFile** and **outFile** cannot contain two consecutive periods
 * and a slash (../). Otherwise, error codes 900001 and 900002 are returned.
 *
 * The name of the zipped file or zipped folder cannot contain two consecutive periods and a slash (../). Otherwise,
 * the error code 900003 is returned.
 *
 * @param { String } inFile - Path of the file to decompress. The file name extension must be .zip. The path must be
 *     an application sandbox path, which can be obtained from the context. For details about the context, see FA Model
 *     and Stage Model. If the .zip file to be unzipped contains Chinese file names or folder names, use UTF-8 to
 *     encode them. Otherwise, garbled characters may be displayed after unzipping.
 * @param { String } outFile - Path of the decompressed file. The path must exist in the system. Otherwise, the
 *     decompression fails. The path must be an application sandbox path, which can be obtained from the context. For
 *     details about the context, see FA Model and Stage Model. If a file or folder with the same name already exists
 *     in the path, they will be overwritten. When multiple threads decompress files at the same time, the values of
 *     **outFile** must be different.
 * @param { Options } options - Decompression parameters.
 * @param { AsyncCallback<Unit> } callback - Callback used to return the result. If the operation is successful,
 *     **null** is returned; otherwise, a specific error code is returned.
 * @throws { BusinessException } 900001 - The input source file is invalid.
 * @throws { BusinessException } 900002 - The input destination file is invalid.
 * @throws { BusinessException } 900003 - The input source file is not in ZIP format or is damaged.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib",
    throwexception: true
]
public func decompressFile(inFile: String, outFile: String, options: Options, callback: AsyncCallback<Unit>): Unit {
    spawn {
        unsafe {
            let cOptions = RetOptions(options)
            try (
                cInFile = LibC.mallocCString(inFile).asResource(),
                cOutFile = LibC.mallocCString(outFile).asResource()
            ) {
                let errCode = FfiBundleManagerDeCompressFileOptions(cInFile.value, cOutFile.value, cOptions)
                invokeAsyncCallbackUnit(callback, errCode, "decompressFile")
            }
        }
    }
}

/**
 * Decompresses a file. This API uses an asynchronous callback to return the result.
 *
 * **NOTE**
 *
 * To avoid path traversal, the input parameters of **inFile** and **outFile** cannot contain two consecutive periods
 * and a slash (../). Otherwise, error codes 900001 and 900002 are returned.
 *
 * The name of the zipped file or zipped folder cannot contain two consecutive periods and a slash (../). Otherwise,
 * the error code 900003 is returned.
 *
 * @param { String } inFile - Path of the file to decompress. The file name extension must be .zip. The path must be
 *     an application sandbox path, which can be obtained from the context. For details about the context, see FA Model
 *     and Stage Model. If the .zip file to be unzipped contains Chinese file names or folder names, use UTF-8 to
 *     encode them. Otherwise, garbled characters may be displayed after unzipping.
 * @param { String } outFile - Path of the decompressed file. The path must exist in the system. Otherwise, the
 *     decompression fails. The path must be an application sandbox path, which can be obtained from the context. For
 *     details about the context, see FA Model and Stage Model. If a file or folder with the same name already exists
 *     in the path, they will be overwritten. When multiple threads decompress files at the same time, the values of
 *     **outFile** must be different.
 * @param { AsyncCallback<Unit> } callback - Callback used to return the result. If the operation is successful,
 *     **null** is returned; otherwise, a specific error code is returned.
 * @throws { BusinessException } 900001 - The input source file is invalid.
 * @throws { BusinessException } 900002 - The input destination file is invalid.
 * @throws { BusinessException } 900003 - The input source file is not in ZIP format or is damaged.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib",
    throwexception: true
]
public func decompressFile(inFile: String, outFile: String, callback: AsyncCallback<Unit>): Unit {
    spawn {
        unsafe {
            try (
                cInFile = LibC.mallocCString(inFile).asResource(),
                cOutFile = LibC.mallocCString(outFile).asResource()
            ) {
                let errCode = FfiBundleManagerDeCompressFile(cInFile.value, cOutFile.value)
                invokeAsyncCallbackUnit(callback, errCode, "decompressFile")
            }
        }
    }
}

/**
 * Obtains the original size of a compressed file. This API uses an asynchronous callback to return the result.
 *
 * @param { String } compressedFile - Specifies the path of the compressed file. Only .zip files are supported. The
 *     path must be an application sandbox path, which can be obtained from the context. For details about the context,
 *     see FA Model and Stage Model.
 * @param { AsyncCallback<Int64> } callback - Callback used to return the original size of the compressed file, in
 *     bytes.
 * @throws { BusinessException } 900001 - The input source file is invalid.
 * @throws { BusinessException } 900003 - The input source file is not in ZIP format or is damaged.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib",
    throwexception: true
]
public func getOriginalSize(compressedFile: String, callback: AsyncCallback<Int64>): Unit {
    spawn {
        unsafe {
            try (cFile = LibC.mallocCString(compressedFile).asResource()) {
                var errCode: Int32 = 0
                let originalSize = FfiBundleManagerGetOriginalSize(cFile.value, inout errCode)
                invokeAsyncCallbackData(callback, errCode, originalSize, "getOriginalSize")
            }
        }
    }
}
