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

import ohos.business_exception.{AsyncCallback, BusinessException, getUniversalErrorMsg}
import ohos.ffi.SUCCESS_CODE
import ohos.labels.APILevel

class GZipImpl {
    let ffiInst_: UIntNative

    init() {
        this.ffiInst_ = unsafe { FfiBundleManagerGZipInstCreate() }
    }

    ~init() {
        unsafe { FfiBundleManagerGZipInstDestroy(this.ffiInst_) }
    }

    prop id: UIntNative {
        get() {
            return ffiInst_
        }
    }
}

/**
 * Describes gzip-related APIs.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public class GZip {
    private var gzipImpl: GZipImpl

    init() {
        this.gzipImpl = GZipImpl()
    }

    /**
     * Associates gzip file with the file descriptor (fd) and opens the file for reading and decompressing, or
     * compressing and writing. This API uses an asynchronous callback to return the result.
     *
     * @param { Int32 } fd - File descriptor. Generally, the value is obtained by calling the **open** method or other
     *     methods.
     * @param { String } mode - Specifies the access mode. For details, see the description of gzopen.
     * @param { AsyncCallback<Unit> } callback - Callback used to return the result. No value is returned.
     * @throws { BusinessException } 17800002 - No such file or access mode error.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzdopen(fd: Int32, mode: String, callback: AsyncCallback<Unit>): Unit {
        spawn {
            unsafe {
                try (cMode = LibC.mallocCString(mode).asResource()) {
                    var errCode: Int32 = 0
                    FfiBundleManagerGZipDopen(gzipImpl.id, fd, cMode.value, inout errCode)
                    invokeAsyncCallbackUnit(callback, errCode, "gzdopen")
                }
            }
        }
    }

    /**
     * Opens the .gz file in the specified path for reading and decompressing, or compressing and writing. This API
     * uses an asynchronous callback to return the result.
     *
     * @param { String } path - Path of the file to be opened.
     * @param { String } mode - Specifies a mode for opening a file.<br>Basic modes (one of the following must be
     *     selected):<br>- **"r"** or **"rb"**: read mode. The system automatically detects and decompresses the gzip
     *     file. If the file is not in gzip format, the original data is directly read.<br>- **"w"** or **"wb"**: write
     *     mode. The system creates a new file and compresses data.<br>- **"a"** or **"ab"**: append mode. The system
     *     appends a new gzip stream to the end of the existing file without verifying the format of the original
     *     file.<br>Optional function parameters (can be used together):<br>- Compression level: **0** (no
     *     compression) to **9** (maximum compression). The default compression level is **6**. This parameter must be
     *     used together with the write or append mode.<br>- Compression strategy: **"f"** (filtering strategy),
     *     **"h"** (Huffman coding strategy), **"R"** (RLE compression strategy), or **"F"** (fixed encoding
     *     strategy). You can only select one of the strategies.<br>- Transparent mode: **"T"**. In this mode, data is
     *     not compressed and no gzip header is generated during writing (a common file is generated). This parameter
     *     is mutually exclusive with the compression strategy parameter.<br>- Exclusive creation: **"x"**. The file
     *     fails to be opened if it already exists. This parameter must be used together with the write or append
     *     mode.<br>- Close-on-exec flag: **"e"**. This parameter is used to set the **FD_CLOEXEC** property of the
     *     file descriptor (system-dependent).<br>Examples:<br>- **"r"**: read mode. Data is read in binary
     *     format.<br>- **"rb"**: read mode. Data is read in binary format.<br>- **"wb6"**: write mode. Data is
     *     written in binary format with the compression level of 6.<br>- **"wb9f"**: write mode. Data is written in
     *     binary format with the maximum compression level and filtering strategy.<br>- **"wbT"**: write mode. Data
     *     is not compressed and a common file is generated.<br>- **"wbx"**: write mode. Data is written to the
     *     exclusively created file in binary format.<br>- **"abx"**: append mode. Data is appended and written to the
     *     exclusively created file in binary format.
     * @param { AsyncCallback<Unit> } callback - Callback used to return the result. No value is returned.
     * @throws { BusinessException } 17800002 - No such file or access mode error.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzopen(path: String, mode: String, callback: AsyncCallback<Unit>): Unit {
        spawn {
            unsafe {
                try (
                    cPath = LibC.mallocCString(path).asResource(),
                    cMode = LibC.mallocCString(mode).asResource()
                ) {
                    var errCode: Int32 = 0
                    FfiBundleManagerGZipOpen(gzipImpl.id, cPath.value, cMode.value, inout errCode)
                    invokeAsyncCallbackUnit(callback, errCode, "gzopen")
                }
            }
        }
    }

    /**
     * Checks whether the position from which data is read has reached the end of the gzip file. This API uses an
     * asynchronous callback to return the result.
     *
     * @param { AsyncCallback<Int32> } callback - Callback used to return the result. If the end-of-file indicator is
     *     set while reading, **1** is returned.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib"
    ]
    public func gzeof(callback: AsyncCallback<Int32>): Unit {
        spawn {
            var errCode: Int32 = 0
            let ret = unsafe { FfiBundleManagerGZipEof(gzipImpl.id, inout errCode) }
            invokeAsyncCallbackData(callback, errCode, ret, "gzeof")
        }
    }

    /**
     * Clears all pending output of the file. Closes the file and releases the decompression or compression state if
     * necessary. This API uses an asynchronous callback to return the result.
     *
     * @param { AsyncCallback<ReturnStatus> } callback - Callback used to return the result.
     * @throws { BusinessException } 17800004 - Compression or decompression stream error, which may be caused by an
     *     initialization error in the zlib stream structure or a modified structure.
     * @throws { BusinessException } 17800006 - Memory allocation failed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzclose(callback: AsyncCallback<ReturnStatus>): Unit {
        spawn {
            var errCode: Int32 = 0
            let ret = unsafe { FfiBundleManagerGZipClose(gzipImpl.id, inout errCode) }
            if (errCode == SUCCESS_CODE) {
                callback(None, Some(ReturnStatus.parse(ret)))
            } else {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
            }
        }
    }

    /**
     * Compresses the uncompressed bytes of the declared length in the buffer and writes them to the file. This API
     * uses an asynchronous callback to return the result.
     *
     * @param { ArrayBuffer } buf - Data buffer pointed by an object to be written.
     * @param { Int64 } len - Length of uncompressed bytes.
     * @param { AsyncCallback<Int64> } callback - Callback used to return the result.
     * @throws { BusinessException } 17800009 - Internal structure error.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzwrite(buf: ArrayBuffer, len: Int64, callback: AsyncCallback<Int64>): Unit {
        spawn {
            if (len > buf.size || len < 0) {
                invokeAsyncCallbackParamError(callback, "gzwrite")
                return
            }
            var errCode: Int32 = 0
            let vp = unsafe { acquireArrayRawData(buf) }
            let ret = unsafe { FfiBundleManagerGZipWrite(gzipImpl.id, vp.pointer, len, inout errCode) }
            unsafe { releaseArrayRawData(vp) }
            invokeAsyncCallbackData(callback, errCode, ret, "gzwrite")
        }
    }

    /**
     * Reads a maximum of **len** uncompressed bytes from a file and decompresses them into the buffer. This API uses
     * an asynchronous callback to return the result.
     *
     * @param { ArrayBuffer } buf - Target offset position.
     * @param { AsyncCallback<Int64> } callback - Callback used to return the result.
     * @throws { BusinessException } 17800009 - Internal structure error.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzread(buf: ArrayBuffer, callback: AsyncCallback<Int64>): Unit {
        spawn {
            var errCode: Int32 = 0
            let vp = unsafe { acquireArrayRawData(buf) }
            let ret = unsafe { FfiBundleManagerGZipRead(gzipImpl.id, vp.pointer, buf.size, inout errCode) }
            unsafe { releaseArrayRawData(vp) }
            invokeAsyncCallbackData(callback, errCode, ret, "gzread")
        }
    }

    /**
     * Compresses the given null-terminated strings and writes them to the file, excluding the null operator. This
     * API uses an asynchronous callback to return the result.
     *
     * @param { String } str - Format descriptors and plain text.
     * @param { AsyncCallback<Int32> } callback - Callback used to return the result.
     * @throws { BusinessException } 17800009 - Internal structure error.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzputs(str: String, callback: AsyncCallback<Int32>): Unit {
        spawn {
            unsafe {
                try (cStr = LibC.mallocCString(str).asResource()) {
                    var errCode: Int32 = 0
                    let ret = FfiBundleManagerGZipPuts(gzipImpl.id, cStr.value, inout errCode)
                    invokeAsyncCallbackData(callback, errCode, ret, "gzputs")
                }
            }
        }
    }

    /**
     * Reads bytes from a compressed file until len-1 characters are read, a newline character is read and transferred
     * to a buffer, or an end-of-file condition is encountered. This API uses an asynchronous callback to return the
     * result.
     *
     * @param { ArrayBuffer } buf - Stores the read row data.
     * @param { AsyncCallback<String> } callback - Callback used to return a string ended with **null**.
     * @throws { BusinessException } 17800009 - Internal structure error.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.BundleManager.Zlib",
        throwexception: true
    ]
    public func gzgets(buf: ArrayBuffer, callback: AsyncCallback<String>): Unit {
        spawn {
            var errCode: Int32 = 0
            let vp = unsafe { acquireArrayRawData(buf) }
            let cStr = unsafe { FfiBundleManagerGZipGets(gzipImpl.id, vp.pointer, buf.size, inout errCode) }
            unsafe { releaseArrayRawData(vp) }
            if (errCode != SUCCESS_CODE) {
                callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
                return
            }
            callback(None, Some(cStr.toString()))
        }
    }
}

/**
 * Creates this **GZip** object. This API uses an asynchronous callback to return the result.
 *
 * @param { AsyncCallback<GZip> } callback - Callback used to return the **GZip** object created.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.BundleManager.Zlib"
]
public func createGZip(callback: AsyncCallback<GZip>): Unit {
    spawn {
        callback(None, Some(GZip()))
    }
}
