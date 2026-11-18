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
import ohos.hilog.HilogChannel
import ohos.ffi.SUCCESS_CODE
import std.collection.HashMap

let ZLIB_LOG = HilogChannel(0, 0xD001100, "CJ-BundleMgrService")

const ERROR_ZLIB_SRC_FILE_INVALID_MSG: String = "The Input source file is invalid."
const ERROR_ZLIB_DEST_FILE_INVALID_MSG: String = "The Input destination file is invalid."
const ERROR_ZLIB_SRC_FILE_FORMAT_ERROR_OR_DAMAGED_MSG: String = "The input source file is not ZIP format or damaged."
const ERROR_ZLIB_NO_SUCH_FILE_OR_ACCESS_MODE_MSG: String = "No such file or access mode error."
const ERROR_ZLIB_ZSTREAM_MSG: String = "ZStream error."
const ERROR_ZLIB_DATA_MSG: String = "Data error."
const ERROR_ZLIB_MEMORY_ALLOC_FAILED_MSG: String = "Memory allocation failed."
const ERROR_ZLIB_BUFFER_MSG: String = "Buffer error."
const ERROR_ZLIB_INTERNAL_STRUCT_MSG: String = "Internal structure error."
let ERROR_CODE_MAP: HashMap<Int32, String> = HashMap<Int32, String>(
    [
        (ERROR_ZLIB_SRC_FILE_INVALID, ERROR_ZLIB_SRC_FILE_INVALID_MSG),
        (ERROR_ZLIB_DEST_FILE_INVALID, ERROR_ZLIB_DEST_FILE_INVALID_MSG),
        (ERROR_ZLIB_SRC_FILE_FORMAT_ERROR_OR_DAMAGED, ERROR_ZLIB_SRC_FILE_FORMAT_ERROR_OR_DAMAGED_MSG),
        (ERROR_ZLIB_NO_SUCH_FILE_OR_ACCESS_MODE, ERROR_ZLIB_NO_SUCH_FILE_OR_ACCESS_MODE_MSG),
        (ERROR_ZLIB_ZSTREAM, ERROR_ZLIB_ZSTREAM_MSG),
        (ERROR_ZLIB_DATA, ERROR_ZLIB_DATA_MSG),
        (ERROR_ZLIB_MEMORY_ALLOC_FAILED, ERROR_ZLIB_MEMORY_ALLOC_FAILED_MSG),
        (ERROR_ZLIB_BUFFER, ERROR_ZLIB_BUFFER_MSG),
        (ERROR_ZLIB_INTERNAL_STRUCT, ERROR_ZLIB_INTERNAL_STRUCT_MSG)
    ]
)

func getErrorMsg(code: Int32): String {
    if (let Some(v) <- getUniversalErrorMsg(code)) {
        return v
    } else if (ERROR_CODE_MAP.contains(code)) {
        return ERROR_CODE_MAP[code]
    } else {
        return "Unknown error code ${code}"
    }
}

// AsyncCallback<Unit> unified callback: success callback(None, None); failure is reported
// through the callback with a BusinessException instead of being thrown.
func invokeAsyncCallbackUnit(callback: AsyncCallback<Unit>, errCode: Int32, funcName: String): Unit {
    if (errCode == SUCCESS_CODE) {
        callback(None, None)
    } else {
        ZLIB_LOG.error("zlib ${funcName} failed: ${getErrorMsg(errCode)}")
        callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
    }
}

// AsyncCallback<T> unified callback with data: success callback(None, Some(data)); failure is
// reported through the callback with a BusinessException instead of being thrown.
func invokeAsyncCallbackData<T>(callback: AsyncCallback<T>, errCode: Int32, data: T, funcName: String): Unit {
    if (errCode == SUCCESS_CODE) {
        callback(None, Some(data))
    } else {
        ZLIB_LOG.error("zlib ${funcName} failed: ${getErrorMsg(errCode)}")
        callback(Some(BusinessException(errCode, getErrorMsg(errCode))), None)
    }
}

// Parameter validation failure: reported through the callback with the universal 401 error
// instead of being thrown.
func invokeAsyncCallbackParamError<T>(callback: AsyncCallback<T>, funcName: String): Unit {
    ZLIB_LOG.error("zlib ${funcName} failed: ${getErrorMsg(UNIVERSAL_PARAM_ERROR)}")
    callback(Some(BusinessException(UNIVERSAL_PARAM_ERROR, getErrorMsg(UNIVERSAL_PARAM_ERROR))), None)
}
